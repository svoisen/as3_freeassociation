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

    public class Wanderer
    {
        //---------------------------------------------------------------------
        //
        // Public Methods
        //
        //---------------------------------------------------------------------
        
        public function getRandomAcyclicPath(startNode:Node, length:int, direction:String = "forward"):Vector.<Node>
        {
            var path:Vector.<Node> = new Vector.<Node>();
            var curNode:Node = startNode;
            for (var i:int = 0; i < length; i++)
            {
                if (!curNode)
                    return null;
                
                path.push(curNode);
                curNode = chooseRandomNode(getPossibleNextNodes(curNode, direction), path);
            }
            
            return path;
        }
        
        //---------------------------------------------------------------------
        //
        // Private Methods
        //
        //---------------------------------------------------------------------
        
        private function getPossibleNextNodes(node:Node, direction:String):Vector.<Node>
        {
            var possibleNextNodes:Vector.<Node>;
            
            if (direction == SearchDirections.FORWARD)
            {
                possibleNextNodes = node.targets; 
            }
            else if (direction == SearchDirections.BACKWARD)
            {
                possibleNextNodes = node.cues; 
            }
            else
            {
                possibleNextNodes = node.targets.concat(node.cues);
            }
            
            return possibleNextNodes;
        }
        
        private function chooseRandomNode(nodes:Vector.<Node>, disallow:Vector.<Node> = null):Node
        {
            var chooseFrom:Vector.<Node> = nodes.concat();
            
            if (disallow)
                removeNodes(disallow, chooseFrom);
            
            if (chooseFrom.length > 0)
                return chooseFrom[Math.round(Math.random()*(chooseFrom.length - 1))]; 
            
            return null;
        }

        private function removeNodes(toRemove:Vector.<Node>, removeFrom:Vector.<Node>):void
        {
            for each (var node:Node in toRemove)
            {
                var i:int = removeFrom.indexOf(node);
                if (i > -1)
                    removeFrom.splice(i, 1);
            }
        }
    }
}