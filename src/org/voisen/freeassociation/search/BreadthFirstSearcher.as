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
    import org.voisen.freeassociation.graph.Node;

    public class BreadthFirstSearcher implements ISearcher
    {
        //---------------------------------------------------------------------
        //
        // Public Methods
        //
        //---------------------------------------------------------------------
        
        public function search(start:Node, end:Node, maxDepth:int = 5):Vector.<Node>
        {
            setupSearch(start,end,maxDepth);
            return performSearch();
        }
        
        //---------------------------------------------------------------------
        //
        // Private Methods
        //
        //---------------------------------------------------------------------
        
        private function setupSearch(start:Node, end:Node, maxDepth:int):void
        {
            var startPath:Vector.<Node> = Vector.<Node>([start]);
            // Queue is an array of paths
            queue = [startPath];
            visited = new Object();
            endNode = end;
            this.maxDepth = maxDepth;
        }

        private function performSearch():Vector.<Node>
        {
            while (queue.length > 0)
            {
                var curPath:Vector.<Node> = queue.shift(); 
                
                if (curPath.length > maxDepth)
                    return null;
                
                var curNode:Node = curPath[curPath.length - 1];
                visited[curNode.word] = true; 
            
                if (curNode == endNode)
                    return curPath;
                
                var targetsCount:int = curNode.targets.length;
                for (var i:int = 0; i < targetsCount; i++)
                {
                    var target:Node = curNode.targets[i];
                    if (!(target.word in visited))
                        queue.push(curPath.concat(Vector.<Node>([target])));
                }
            }
            
            return null;
        }
        
        //---------------------------------------------------------------------
        //
        // Properties
        //
        //---------------------------------------------------------------------
        
        private var queue:Array;
        private var visited:Object;
        private var endNode:Node;
        private var maxDepth:int;
    }
}