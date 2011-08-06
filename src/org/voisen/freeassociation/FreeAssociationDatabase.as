/**
 * Copyright (c) 2011 Sean Voisen
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy 
 * of this software and associated documentation files (the "Software"), to 
 * deal in the Software without restriction, including without limitation the 
 * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or 
 * sell copies of the Software, and to permit persons to whom the Software is 
 * furnished to do so, subject to the following conditions:
 *   
 * The above copyright notice and this permission notice shall be included in 
 * all copies or substantial portions of the Software.
 *   
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING 
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS 
 * IN THE SOFTWARE.
 */

package org.voisen.freeassociation
{
    import org.voisen.freeassociation.data.CSVData;
    import org.voisen.freeassociation.data.Node;

    public class FreeAssociationDatabase
    {
        //---------------------------------------------------------------------
        //
        // Constructor
        //
        //---------------------------------------------------------------------
        
        public function FreeAssociationDatabase()
        {
        }
        
        //---------------------------------------------------------------------
        //
        // Public Methods
        //
        //---------------------------------------------------------------------
        
        public function initialize():void
        {
            var rows:Vector.<String> = new CSVData().rows;
            
            for (var i:int = rows.length - 1; i >= 0; i--)
                addDataFromRow(rows[i]);        
        }
        
        public function hasWord(word:String):Boolean
        {
            word = word.toUpperCase();
            return (word in hash);
        }
        
        public function getTargetsForCue(word:String):Vector.<String>
        {
            word = word.toUpperCase();
            var cueNode:Node = hash[word];
            
            if (cueNode)
               return cueNode.targetsAsStrings;
            
            return null;
        }
        
        public function getShortestForwardPath(startWord:String, endWord:String):Vector.<String>
        {
            if (!(hasWord(startWord) && hasWord(endWord)))
                return null;
            
            startWord = startWord.toUpperCase();
            endWord = endWord.toUpperCase();
           
            var startNode:Node = hash[startWord];
            var startPath:Vector.<Node> = Vector.<Node>([startNode]);
            var startQueue:Array = [startPath];
            var visited:Object = {};
            var endNode:Node = hash[endWord];
            
            return nodeVectorToStringVector(breadthFirstSearch(startQueue, endNode, visited));
        }
        
        public function getForwardPath(startWord:String, endWord:String):Vector.<String>
        {
            if (!(hasWord(startWord) && hasWord(endWord)))
                return null;
            
            startWord = startWord.toUpperCase();
            endWord = endWord.toUpperCase();
            
            var startStack:Vector.<Node> = Vector.<Node>([hash[startWord]]);
            var endNode:Node = hash[endWord];
            var path:Vector.<Node> = new Vector.<Node>();
            var visited:Object = {};
            
            var result:Vector.<Node> = depthFirstSearch(startStack, endNode, path, visited);
            return nodeVectorToStringVector(result);
        }
        
        //---------------------------------------------------------------------
        //
        // Mutators
        //
        //---------------------------------------------------------------------
        
        //---------------------------------------------------------------------
        // wordCount
        //---------------------------------------------------------------------
        
        // wordCount is same as nodeCount, but we expose as wordCount for
        // user-friendliness
        private var _wordCount:int = 0;
        public function get wordCount():int
        {
            return _wordCount;
        }
       
        //---------------------------------------------------------------------
        //
        // Private Methods
        //
        //---------------------------------------------------------------------
        
        private function nodeVectorToStringVector(vector:Vector.<Node>):Vector.<String>
        {
            if (!vector)
                return null;
            
            var result:Vector.<String> = new Vector.<String>();
            for (var i:int = 0; i < vector.length; i++)
                result.push(vector[i].word);
            
            return result;
        }
        
        private function addDataFromRow(row:String):void
        {
            var data:Array = row.split(', '); 
            var cue:String = data[0];
            var target:String = data[1];
            var cueNode:Node = hash[cue];
            var targetNode:Node = hash[target];
            
            if (!cueNode)
                cueNode = addNode(cue);
            
            if (!targetNode)
                targetNode = addNode(target);
            
            cueNode.addTarget(targetNode);
        }
        
        private function addNode(word:String):Node
        {
            var newNode:Node = new Node(word);
            hash[word] = newNode;
            _wordCount++;
            return newNode;
        }
        
        private function breadthFirstSearch(queue:Array, endNode:Node, visited:Object):Vector.<Node>
        {
            if (queue.length == 0)
                return null;
            
            var curPath:Vector.<Node> = queue.shift();
            var curNode:Node = curPath[curPath.length - 1];
            visited[curNode.word] = true; 
            
            if (curNode == endNode)
                return curPath;
            
            for (var i:int = 0; i < curNode.targets.length; i++)
            {
                var target:Node = curNode.targets[i];
                if (!(target.word in visited))
                    queue.push(curPath.concat(Vector.<Node>([target])));
            }
            
            return breadthFirstSearch(queue, endNode, visited);
        }
        
        private function depthFirstSearch(stack:Vector.<Node>, endNode:Node, path:Vector.<Node>, visited:Object):Vector.<Node>
        {
            var curNode:Node = stack.shift();
            path.push(curNode);
            visited[curNode.word] = true;
            
            if (curNode == endNode)
                return path;
            
            var pushedTargets:Boolean = false;
            var targetsLength:int = curNode.targets.length;
            for (var i:int = 0; i < targetsLength; i++)
            {
                var target:Node = curNode.targets[i];
                if (!(target.word in visited))
                {
                    pushedTargets = true;
                    stack.push(target);
                }
            }
            
            if (!pushedTargets)
                path.pop();
            
            return depthFirstSearch(stack, endNode, path, visited);
        }
        
        //---------------------------------------------------------------------
        //
        // Properties
        //
        //---------------------------------------------------------------------
        
        private var hash:Object = new Object();
    }
}
