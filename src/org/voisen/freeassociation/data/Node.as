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

package org.voisen.freeassociation.data
{
    public class Node
    {
        //---------------------------------------------------------------------
        //
        // Constructor
        //
        //---------------------------------------------------------------------
        
        public function Node(word:String)
        {
            this.word = word;
        }
        
        //---------------------------------------------------------------------
        //
        // Mutators
        //
        //---------------------------------------------------------------------
        
        //---------------------------------------------------------------------
        // value
        //---------------------------------------------------------------------
        
        private var _word:String;

        public function get word():String
        {
            return _word;
        }

        public function set word(value:String):void
        {
            value = value.toUpperCase();
            
            if (value == _word)
                return;
            
            _word = value;
        }
        
        //---------------------------------------------------------------------
        // responseCount
        //---------------------------------------------------------------------
        
        public function get responseCount():int
        {
            return responseNeighbors.length;
        }
        
        public function get cueCount():int
        {
            return cueNeighbors.length;
        }
        
        //---------------------------------------------------------------------
        //
        // Public Methods
        //
        //---------------------------------------------------------------------
        
        public function addResponseNeighbor(node:Node):void
        {
            if (responseNeighbors.indexOf(node) == -1)
                responseNeighbors.push(node);
            
            node.addCueNeighbor(this);
        }
        
        public function addCueNeighbor(node:Node):void
        {
            if (cueNeighbors.indexOf(node) == -1)
                cueNeighbors.push(node);
        }
        
        public function hasResponse(node:Node):Boolean
        {
            return false;
        }
        
        public function hasResponseNeighborWithWord(word:String):Boolean
        {
            var index:int = getIndexForNeighborWithWord(responseNeighbors, word);
            
            return index > -1;
        }
        
        public function removeResponseNeighborWithWord(word:String):Boolean
        {
            var index:int = getIndexForNeighborWithWord(responseNeighbors, word);
            
            if (index > -1)
            {
                responseNeighbors.splice(index, 1);
                return true;
            }
            
            return false;
        }
        
        public function getResponseNeighborWithWord(word:String):Node
        {
            var index:int = getIndexForNeighborWithWord(responseNeighbors, word);
            
            if (index > -1)
                return responseNeighbors[index] as Node;
            
            return null;
        }
        
        //---------------------------------------------------------------------
        //
        // Private Methods
        //
        //---------------------------------------------------------------------
        
        private function getIndexForNeighborWithWord(neighborsVector:Vector.<Node>, word:String):int
        {
            word = word.toUpperCase();
            
            for (var i:int = neighborsVector.length - 1; i >= 0; i--)
            {
                if (neighborsVector[i].word == word)
                    return i;
            }
            
            return -1;
        }
        
        //---------------------------------------------------------------------
        //
        // Properties
        //
        //---------------------------------------------------------------------
        
        private var responseNeighbors:Vector.<Node> = new Vector.<Node>();
        private var cueNeighbors:Vector.<Node> = new Vector.<Node>();
    }
}