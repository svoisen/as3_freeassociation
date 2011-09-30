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
            var startPath:Vector.<Node> = Vector.<Node>([start]);
            // Queue is an array of paths
            queue = [startPath];
            visited = new Object();
            endNode = end;
            this.maxDepth = maxDepth;
            this.direction = direction;
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
                
                if (direction == SearchDirections.FORWARD || direction == SearchDirections.BIDIRECTIONAL)
                    enqueueNeighbors(curNode.targets, curPath);
                
                if (direction == SearchDirections.BACKWARD || direction == SearchDirections.BIDIRECTIONAL)
                    enqueueNeighbors(curNode.cues, curPath);
            }
            
            return null;
        }

        private function enqueueNeighbors(neighbors:Vector.<Node>, curPath:Vector.<Node>):void
        {
            var neighborsCount:int = neighbors.length;
            for (var i:int = 0; i < neighborsCount; i++)
            {
                var neighbor:Node = neighbors[i];
                if (!(neighbor.word in visited))
                    queue.push(curPath.concat(Vector.<Node>([neighbor])));
            }
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
        private var direction:String;
    }
}