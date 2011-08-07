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
    import org.voisen.freeassociation.search.BreadthFirstSearcher;
    import org.voisen.freeassociation.search.DepthFirstSearcher;
    import org.voisen.freeassociation.search.SearchTypes;

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
            return (word in graph);
        }
        
        public function getTargetsForCue(word:String):Vector.<String>
        {
            word = word.toUpperCase();
            var cueNode:Node = graph[word];
            
            if (cueNode)
               return cueNode.targetsAsStrings;
            
            return null;
        }
        
        public function getCueTargetPath(start:String, end:String, searchType:String = "bfs"):Vector.<String>
        {
            if (!(hasWord(start) && hasWord(end)))
                return null;
            
            var startNode:Node = graph[start.toUpperCase()];
            var endNode:Node = graph[end.toUpperCase()];
            var result:Vector.<Node>;
            
            if (searchType == SearchTypes.BFS)
            {
                result = new BreadthFirstSearcher().search(startNode, endNode);
            }
            else if (searchType == SearchTypes.DFS)
            {
                result = new DepthFirstSearcher().search(startNode, endNode);
            }
            
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
            var cueNode:Node = graph[cue];
            var targetNode:Node = graph[target];
            
            if (!cueNode)
                cueNode = addNode(cue);
            
            if (!targetNode)
                targetNode = addNode(target);
            
            cueNode.addTarget(targetNode);
        }
        
        private function addNode(word:String):Node
        {
            var newNode:Node = new Node(word);
            graph[word] = newNode;
            _wordCount++;
            return newNode;
        }
        
        //---------------------------------------------------------------------
        //
        // Properties
        //
        //---------------------------------------------------------------------
        
        private var graph:Object = new Object();
    }
}
