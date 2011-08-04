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
        // degree
        //---------------------------------------------------------------------
        
        public function get degree():int
        {
            return edges.length;
        }
        
        //---------------------------------------------------------------------
        //
        // Public Methods
        //
        //---------------------------------------------------------------------
        
        public function addEdge(edge:Edge):void
        {
           if (edge && !hasEdgeWithWord(edge.word))
               edges.push(edge);
        }
        
        public function hasEdgeWithWord(word:String):Boolean
        {
            var index:int = getIndexForEdgeWithWord(word);
            
            return index > -1;
        }
        
        public function removeEdgeWithWord(word:String):Boolean
        {
            var index:int = getIndexForEdgeWithWord(word);
            
            if (index > -1)
            {
                edges.splice(index, 1);
                return true;
            }
            
            return false;
        }
        
        public function getEdgeWithWord(word:String):Edge
        {
            var index:int = getIndexForEdgeWithWord(word);
            
            if (index > -1)
                return edges[index];
            
            return null;
        }
        
        //---------------------------------------------------------------------
        //
        // Private Methods
        //
        //---------------------------------------------------------------------
        
        private function getIndexForEdgeWithWord(word:String):int
        {
            word = word.toUpperCase();
            
            for (var i:int = edges.length - 1; i >= 0; i--)
            {
                if (edges[i].word == word)
                    return i;
            }
            
            return -1;
        }
        
        //---------------------------------------------------------------------
        //
        // Properties
        //
        //---------------------------------------------------------------------
        
        private var edges:Vector.<Edge> = new Vector.<Edge>();
    }
}