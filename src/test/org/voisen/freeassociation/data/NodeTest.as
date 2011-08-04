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

package test.org.voisen.freeassociation.data
{
    import org.flexunit.asserts.assertEquals;
    import org.flexunit.asserts.assertTrue;
    import org.voisen.freeassociation.data.Edge;
    import org.voisen.freeassociation.data.Node;

    public class NodeTest
    {
        //---------------------------------------------------------------------
        //
        // Prep
        //
        //---------------------------------------------------------------------
        
        [Before]
        public function setUp():void
        {
           node = new Node("WORD"); 
        }
        
        [After]
        public function tearDown():void
        {
           node = null; 
        }
        
        //---------------------------------------------------------------------
        //
        // Tests
        //
        //---------------------------------------------------------------------
        
        [Test]
        public function should_set_value_in_constructor():void
        {
            assertEquals(node.word, "WORD");
        }
        
        [Test]
        public function should_be_able_to_set_and_get_word():void
        {
            node.word = "WORD";
            assertEquals(node.word, "WORD"); 
        }
        
        [Test]
        public function should_be_able_to_add_edge():void
        {
            addSampleEdge();
            
            assertEquals(node.numEdges, 1);
        }
        [Test]
        public function should_be_able_to_remove_edge():void
        {
            addSampleEdge();
            
            var result:Boolean = node.removeEdgeWithWord("MOTHER");
            
            assertTrue(result);
            assertEquals(node.numEdges, 0);
        }
        
        //---------------------------------------------------------------------
        //
        // Helpers
        //
        //---------------------------------------------------------------------
        
        private function createSampleEdge():Edge
        {
            return new Edge("MOTHER");
        }

        private function addSampleEdge():void
        {
            var edge:Edge = createSampleEdge();
            node.addEdge(edge);
        }
        
        //---------------------------------------------------------------------
        //
        // Properties
        //
        //---------------------------------------------------------------------
        
        private var node:Node;
    }
}