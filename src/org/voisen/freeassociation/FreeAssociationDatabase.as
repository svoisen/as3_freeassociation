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
    import org.voisen.freeassociation.data.FullUSFData;
    import org.voisen.freeassociation.data.ICSVData;
    import org.voisen.freeassociation.graph.Graph;
    import org.voisen.freeassociation.graph.Node;
    import org.voisen.freeassociation.search.BreadthFirstSearcher;
    import org.voisen.freeassociation.search.DepthFirstSearcher;
    import org.voisen.freeassociation.search.SearchDirections;
    import org.voisen.freeassociation.search.SearchTypes;

    public class FreeAssociationDatabase
    {
        //---------------------------------------------------------------------
        //
        // Constructor
        //
        //---------------------------------------------------------------------
        
        public function FreeAssociationDatabase()
        {
        }
        
        //---------------------------------------------------------------------
        //
        // Public Methods
        //
        //---------------------------------------------------------------------
        
        public function initialize(data:ICSVData):void
        {
            graph = new Graph();
            var rows:Vector.<String> = data.rows;
            
            for (var i:int = rows.length - 1; i >= 0; i--)
                addDataFromRow(rows[i]);        
        }
        
        public function hasWord(word:String):Boolean
        {
            word = word.toUpperCase();
            return graph.hasNode(word);
        }
        
        public function getTargetsForCue(word:String):Vector.<String>
        {
            word = word.toUpperCase();
            var cueNode:Node = graph.getNode(word);
            
            if (cueNode)
               return cueNode.targetsAsStrings;
            
            return null;
        }
        
        public function getCuesForTarget(word:String):Vector.<String>
        {
            word = word.toUpperCase();
            var targetNode:Node = graph.getNode(word);
            
            if (targetNode)
                return targetNode.cuesAsStrings;
            
            return null;
        }
        
        public function findCueTargetPath(start:String, end:String, searchType:String = "bfs", maxDepth:int = 5):Vector.<String>
        {
            if (!(hasWord(start) && hasWord(end)))
                return null;
            
            var startNode:Node = graph.getNode(start.toUpperCase());
            var endNode:Node = graph.getNode(end.toUpperCase());
            var result:Vector.<Node> = performSearch(startNode, endNode, maxDepth, searchType, SearchDirections.FORWARD);
            
            return nodeVectorToStringVector(result);
        }
        
        public function findTargetCuePath(start:String, end:String, searchType:String = "bfs", maxDepth:int = 5):Vector.<String>
        {
            if (!(hasWord(start) && hasWord(end)))
                return null;
            
            var startNode:Node = graph.getNode(start.toUpperCase());
            var endNode:Node = graph.getNode(end.toUpperCase());
            var result:Vector.<Node> = performSearch(startNode, endNode, maxDepth, searchType, SearchDirections.BACKWARD);
            
            return nodeVectorToStringVector(result); 
        }
        
        public function findPath(start:String, end:String, searchType:String = "bfs", maxDepth:int = 5):Vector.<String>
        {
            if (!(hasWord(start) && hasWord(end)))
                return null;
            
            var startNode:Node = graph.getNode(start.toUpperCase());
            var endNode:Node = graph.getNode(end.toUpperCase());
            var result:Vector.<Node> = performSearch(startNode, endNode, maxDepth, searchType, SearchDirections.BIDIRECTIONAL);
            
            return nodeVectorToStringVector(result); 
        }
        
        public function getRandomAcyclicPath(start:String, length:int):Vector.<String>
        {
            if (!hasWord(start))
                return null;
            
            var startNode:Node = graph.getNode(start.toUpperCase());
            return null;
        }
        
        //---------------------------------------------------------------------
        //
        // Mutators
        //
        //---------------------------------------------------------------------
        
        //---------------------------------------------------------------------
        // wordCount
        //---------------------------------------------------------------------
        
        public function get wordCount():int
        {
            return graph.nodeCount;
        }
       
        //---------------------------------------------------------------------
        //
        // Private Methods
        //
        //---------------------------------------------------------------------
        
        private function nodeVectorToStringVector(vector:Vector.<Node>):Vector.<String>
        {
            if (!vector)
                return null;
            
            var result:Vector.<String> = new Vector.<String>();
            for (var i:int = 0; i < vector.length; i++)
                result.push(vector[i].word);
            
            return result;
        }
        
        private function addDataFromRow(row:String):void
        {
            var data:Array = row.split(', '); 
            var cue:String = data[0];
            var target:String = data[1];
            
            graph.addEdge(cue, target); 
        }

        private function performSearch(startNode:Node, endNode:Node, maxDepth:int, searchType:String, direction:String):Vector.<Node>
        {
            if (searchType == SearchTypes.BFS)
                return new BreadthFirstSearcher().findPath(startNode, endNode, maxDepth, direction);
            
            if (searchType == SearchTypes.DFS)
                return new DepthFirstSearcher().findPath(startNode, endNode, maxDepth, direction);
            
            return null;
        }
        
        //---------------------------------------------------------------------
        //
        // Properties
        //
        //---------------------------------------------------------------------
        
        private var graph:Graph = new Graph();
    }
}
