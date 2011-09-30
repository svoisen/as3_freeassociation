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

package org.voisen.freeassociation.graph
{

    public class Graph
    {
        //---------------------------------------------------------------------
        //
        // Public Methods
        //
        //---------------------------------------------------------------------
        
        public function addEdge(cue:String, target:String):void
        {
            var cueNode:Node = hash[cue];
            var targetNode:Node = hash[target];
            
            if (!cueNode)
                cueNode = addNode(cue);
            
            if (!targetNode)
                targetNode = addNode(target);
            
            cueNode.addTarget(targetNode);
        }
        
        public function hasNode(word:String):Boolean
        {
            return (word in hash); 
        }
        
        public function getNode(word:String):Node
        {
            return hash[word];
        }
        
        public function getRandomNode():Node
        {
            return getNode(words[Math.round(Math.random()*(words.length - 1))]);
        }
        
        //---------------------------------------------------------------------
        //
        // Mutators
        //
        //---------------------------------------------------------------------
        
        public function get nodeCount():int
        {
            return words.length;
        }
        
        //---------------------------------------------------------------------
        //
        // Private Methods
        //
        //---------------------------------------------------------------------
        
        private function addNode(word:String):Node
        {
            var newNode:Node = new Node(word);
            hash[word] = newNode;
            words.push(word);
            return newNode;
        } 
        
        //---------------------------------------------------------------------
        //
        // Properties
        //
        //---------------------------------------------------------------------
        
        private var hash:Object = new Object();
        private var words:Vector.<String> = new Vector.<String>();
    }
}