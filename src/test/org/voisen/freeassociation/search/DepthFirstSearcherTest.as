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

package test.org.voisen.freeassociation.search
{
    import org.flexunit.asserts.assertEquals;
    import org.voisen.freeassociation.graph.Graph;
    import org.voisen.freeassociation.graph.Node;
    import org.voisen.freeassociation.search.DepthFirstSearcher;
    import org.voisen.freeassociation.search.SearchDirections;

    public class DepthFirstSearcherTest
    {
        //---------------------------------------------------------------------
        //
        // Prep
        //
        //---------------------------------------------------------------------
        
        [Before]
        public function setUp():void
        {
            searcher = new DepthFirstSearcher();
            graph = new Graph();
            graph.addEdge("a", "b");
            graph.addEdge("a", "c");
            graph.addEdge("b", "d");
            graph.addEdge("b", "e");
            graph.addEdge("c", "e"); 
        }
        
        [After]
        public function tearDown():void
        {
            searcher = null;
            graph = null;
        }
        
        //---------------------------------------------------------------------
        //
        // Tests
        //
        //---------------------------------------------------------------------
        
        [Test]
        public function should_search_in_forward_direction():void
        {
            var path:Vector.<Node> = searcher.search(graph.getNode("a"), graph.getNode("e"), 5, SearchDirections.FORWARD);
            assertEquals(path.length, 3); 
        }
        
        [Test]
        public function should_search_in_backward_direction():void
        {
            var path:Vector.<Node> = searcher.search(graph.getNode("e"), graph.getNode("a"), 5, SearchDirections.BACKWARD);
            assertEquals(path.length, 3); 
        }
        
        //---------------------------------------------------------------------
        //
        // Properties
        //
        //---------------------------------------------------------------------
        
        private var searcher:DepthFirstSearcher;
        private var graph:Graph;
    }
}