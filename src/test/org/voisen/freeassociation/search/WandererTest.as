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
    import org.flexunit.asserts.assertNull;
    import org.voisen.freeassociation.graph.Graph;
    import org.voisen.freeassociation.graph.Node;
    import org.voisen.freeassociation.search.Wanderer;

    public class WandererTest
    {
        //---------------------------------------------------------------------
        //
        // Prep
        //
        //---------------------------------------------------------------------
        
        [Before]
        public function setUp():void
        {
            wanderer = new Wanderer();    
            
            graph = new Graph();
            graph.addEdge("a", "b");
            graph.addEdge("a", "c");
            graph.addEdge("b", "d");
            graph.addEdge("b", "a");
            graph.addEdge("c", "e");
        }
        
        [After]
        public function tearDown():void
        {
            wanderer = null; 
        }
        
        //---------------------------------------------------------------------
        //
        // Tests
        //
        //---------------------------------------------------------------------
        
        [Test]
        public function path_of_length_0_should_be_empty():void
        {
            var start:Node = graph.getNode("a");
            assertEquals(wanderer.getRandomAcyclicPath(start, 0).length, 0);
        }
        
        [Test]
        public function start_node_should_be_first_node_in_path():void
        {
            var start:Node = graph.getNode("a");
            var path:Vector.<Node> = wanderer.getRandomAcyclicPath(start, 1);
            
            assertEquals(start, path[0]);
        }
        
        [Test]
        public function should_get_acyclic_path_of_proper_length():void
        {
            var path:Vector.<Node> = wanderer.getRandomAcyclicPath(graph.getNode("a"), 3);
            
            assertEquals(path.length, 3);
        }
        
        [Test]
        public function should_return_null_if_no_path_of_length_exists():void
        {
            var path:Vector.<Node> = wanderer.getRandomAcyclicPath(graph.getNode("c"), 3);
            
            assertNull(path);
        }
        
        //---------------------------------------------------------------------
        //
        // Properties
        //
        //---------------------------------------------------------------------
        
        private var wanderer:Wanderer;
        private var graph:Graph;
    }
}