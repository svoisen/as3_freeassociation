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
        // targetCount
        //---------------------------------------------------------------------
        
        public function get targetCount():int
        {
            return _targets.length;
        }
        
        //---------------------------------------------------------------------
        // cueCount
        //---------------------------------------------------------------------
        
        public function get cueCount():int
        {
            return _cues.length;
        }
        
        //---------------------------------------------------------------------
        // targetsAsStrings
        //---------------------------------------------------------------------
        
        public function get targetsAsStrings():Vector.<String>
        {
           return nodeVectorToStringVector(_targets); 
        }
        
        //---------------------------------------------------------------------
        // targets
        //---------------------------------------------------------------------
        
        private var _targets:Vector.<Node> = new Vector.<Node>();
        public function get targets():Vector.<Node>
        {
            return _targets;    
        }
        
        //---------------------------------------------------------------------
        // cuesAsStrings
        //---------------------------------------------------------------------
        
        public function get cuesAsStrings():Vector.<String>
        {
            return nodeVectorToStringVector(_cues);
        }
        
        //---------------------------------------------------------------------
        //
        // Public Methods
        //
        //---------------------------------------------------------------------
        
        public function addTarget(node:Node):void
        {
            if (!hasTarget(node))
                _targets.push(node);
            
            node.addCue(this);
        }
        
        public function addCue(node:Node):void
        {
            if (!hasCue(node))
                _cues.push(node);
        }
        
        public function hasTarget(node:Node):Boolean
        {
            return _targets.indexOf(node) > -1;
        }
        
        public function hasCue(node:Node):Boolean
        {
            return _cues.indexOf(node) > -1;
        }
        
        public function hasTargetWithWord(word:String):Boolean
        {
            var index:int = getIndexForNeighborWithWord(_targets, word);
            
            return index > -1;
        }
        
        public function removeTargetWithWord(word:String):Boolean
        {
            var index:int = getIndexForNeighborWithWord(_targets, word);
            
            if (index > -1)
            {
                _targets.splice(index, 1);
                return true;
            }
            
            return false;
        }
        
        public function getTargetWithWord(word:String):Node
        {
            var index:int = getIndexForNeighborWithWord(_targets, word);
            
            if (index > -1)
                return _targets[index] as Node;
            
            return null;
        }
        
        //---------------------------------------------------------------------
        //
        // Private Methods
        //
        //---------------------------------------------------------------------
        
        private function nodeVectorToStringVector(vector:Vector.<Node>):Vector.<String>
        {
            var strings:Vector.<String> = new Vector.<String>();
            
            for each(var node:Node in vector)
                strings.push(node.word);
                
            return strings;
        }
        
        private function getIndexForNeighborWithWord(vector:Vector.<Node>, word:String):int
        {
            word = word.toUpperCase();
            
            for (var i:int = vector.length - 1; i >= 0; i--)
            {
                if (vector[i].word == word)
                    return i;
            }
            
            return -1;
        }
        
        //---------------------------------------------------------------------
        //
        // Properties
        //
        //---------------------------------------------------------------------
        
        private var _cues:Vector.<Node> = new Vector.<Node>();
    }
}