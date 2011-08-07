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

package org.voisen.freeassociation.search
{
    import org.voisen.freeassociation.data.Node;

    public class BreadthFirstSearcher implements ISearcher
    {
        //---------------------------------------------------------------------
        //
        // Public Methods
        //
        //---------------------------------------------------------------------
        
        public function search(start:Node, end:Node):Vector.<Node>
        {
            var startPath:Vector.<Node> = Vector.<Node>([start]);
            // Queue is an array of paths
            var startQueue:Array = [startPath];
            var visited:Object = {};
            
            return breadthFirstSearch(startQueue, end, visited);
        }
        
        //---------------------------------------------------------------------
        //
        // Private Methods
        //
        //---------------------------------------------------------------------
        
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
    }
}