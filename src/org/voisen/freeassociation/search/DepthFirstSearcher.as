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
    import flashx.textLayout.formats.Direction;
    
    import org.voisen.freeassociation.graph.Node;
    
    public class DepthFirstSearcher implements ISearcher
    {
        //---------------------------------------------------------------------
        //
        // Public Methods
        //
        //---------------------------------------------------------------------
        
        public function findPath(start:Node, end:Node, maxDepth:int = 5, direction:String = "bidirectional"):Vector.<Node>
        {
            setupSearch(start, end, maxDepth, direction);
            return performSearch();
        }
        
        public function findAllPaths(start:Node, end:Node, maxDepth:int = 5, direction:String = "bidirectional"):Array
        {
            setupSearch(start, end, maxDepth, direction);
            
            return null;
        }

        //---------------------------------------------------------------------
        //
        // Private Methods
        //
        //---------------------------------------------------------------------
        
        private function setupSearch(start:Node, end:Node, maxDepth:int, direction:String):void
        {
            stack = Vector.<Node>([start]);
            path = new Vector.<Node>();
            visited = new Object();
            endNode = end;
            this.direction = direction; 
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
                
                if (direction == SearchDirections.BIDIRECTIONAL || direction == SearchDirections.FORWARD)
                    pushedTargets = pushedTargets || pushNeighbors(curNode.targets);
                
                if (direction == SearchDirections.BIDIRECTIONAL || direction == SearchDirections.BACKWARD)
                    pushedTargets = pushedTargets || pushNeighbors(curNode.cues);
                
                if (!pushedTargets)
                    path.pop();
            }
                
            return null;
        }


        private function pushNeighbors(neighbors:Vector.<Node>):Boolean
        {
            var pushed:Boolean = false;
            var neighborsLength:int = neighbors.length; 
            for (var i:int = 0; i < neighborsLength && path.length < maxDepth; i++)
            {
                var neighbor:Node = neighbors[i];
                if (!(neighbor.word in visited))
                {
                    pushed = true;
                    stack.push(neighbor);
                }
            }
            
            return pushed;
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
        private var direction:String;
    }
}