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
        
        public function Node(value:String)
        {
            _word = value;
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
            if (value != _word)
                _word = value;
        }
        
        //---------------------------------------------------------------------
        // numEdges
        //---------------------------------------------------------------------
        
        public function get numEdges():int
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
            return false;
        }
        
        public function removeEdgeWithWord(word:String):Boolean
        {
            for (var i:int = edges.length - 1; i >= 0; i--)
            {
                if (edges[i].word == word)
                {
                    edges.splice(i, 1);
                    return true;
                }
            }
            
            return false;
        }
        
        //---------------------------------------------------------------------
        //
        // Properties
        //
        //---------------------------------------------------------------------
        
        private var edges:Vector.<Edge> = new Vector.<Edge>();
    }
}