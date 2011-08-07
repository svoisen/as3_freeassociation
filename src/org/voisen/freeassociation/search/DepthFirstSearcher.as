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
    
    public class DepthFirstSearcher implements ISearcher
    {
        //---------------------------------------------------------------------
        //
        // Public Methods
        //
        //---------------------------------------------------------------------
        
        public function search(start:Node, end:Node, maxDepth:int = 5):Vector.<Node>
        {
            setupSearch(start, end, maxDepth);
            return performSearch();
        }

        //---------------------------------------------------------------------
        //
        // Private Methods
        //
        //---------------------------------------------------------------------
        
        private function setupSearch(start:Node, end:Node, maxDepth:int):void
        {
            stack = Vector.<Node>([start]);
            path = new Vector.<Node>();
            visited = new Object();
            endNode = end;
            this.maxDepth = maxDepth;
        }
        
        private function performSearch():Vector.<Node>
        {
            while (stack.length > 0)
            {
                var curNode:Node = stack.pop();
                path.push(curNode);
                visited[curNode.word] = true;
                
                if (curNode == endNode)
                    return path;
                
                var pushedTargets:Boolean = false;
                var targetsLength:int = curNode.targets.length;
                for (var i:int = 0; i < targetsLength && path.length < maxDepth; i++)
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
            }
                
            return null;
        }
        
        //---------------------------------------------------------------------
        //
        // Properties
        //
        //---------------------------------------------------------------------
        
        private var stack:Vector.<Node>;
        private var path:Vector.<Node>;
        private var visited:Object;
        private var maxDepth:int; 
        private var endNode:Node;
    }
}