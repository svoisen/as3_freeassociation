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
    public class FreeAssociationDatabase
    {
        public function FreeAssociationDatabase()
        {
        }
        
        public function initialize():void
        {
            /*var rows:Vector.<String> = new CSVData().rows;
            var rowsCount:int = rows.length;
            var i:int = 0; 
            var currentRow:Array = rows[i].split(',');
            
            while (i < rowsCount - 1)
            {
                var currentWord:String = currentRow[0]; 
                var node:Node = new QuickNode(currentWord);
                   
                while (currentRow[0] == currentWord)
                {
                       node.addResponseNeighbor(new Edge(currentRow[1]));
                       currentRow = i < rowsCount - 1 ? rows[++i].split(',') : [null];
                }
                
                hash[node.word] = node;
                _nodeCount++;
            }*/
        }
        
        private var _nodeCount:int = 0;
        public function get nodeCount():int
        {
            return _nodeCount;
        }
       
        private var hash:Object = new Object();
    }
}
