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
    import org.flexunit.assertThat;
    import org.flexunit.asserts.assertEquals;
    import org.flexunit.asserts.assertTrue;
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
            node.word = "MOTHER";
            assertEquals(node.word, "MOTHER"); 
        }
        
        [Test]
        public function should_convert_word_to_uppercase():void
        {
            node.word = "word";
            assertEquals(node.word, "WORD");
        }
        
        [Test]
        public function should_be_able_to_add_response():void
        {
            addSampleResponse();
            
            assertEquals(node.responseCount, 1);
        }
        
        [Test]
        public function should_be_able_to_add_cue():void
        {
            addSampleCue();
            
            assertEquals(node.cueCount, 1);
        }
        
        [Test]
        public function should_add_self_as_cue_to_response():void
        {
            var response:Node = addSampleResponse();
            
            assertThat(response.hasResponse(node));
        }
                
        [Test]
        public function should_be_able_to_remove_neighbor_by_word():void
        {
            addSampleResponse();
            
            var result:Boolean = node.removeResponseNeighborWithWord("MOTHER");
            
            assertTrue(result);
            assertEquals(node.responseCount, 0);
        }
        
        [Test]
        public function should_be_able_to_determine_if_response_already_exists_by_word():void
        {
            var response:Node = addSampleResponse();
            
            assertTrue(node.hasResponseNeighborWithWord(response.word))
        }
        
        [Test]
        public function should_be_able_to_get_response_by_word():void
        {
            var response:Node = addSampleResponse();
            
            assertEquals(node.getResponseNeighborWithWord(response.word), response);
        }
        
        [Test]
        public function should_be_case_insensitive_when_searching_neighbors_by_word():void
        {
           var response:Node = addSampleResponse();
           
           assertEquals(node.getResponseNeighborWithWord("mOTheR"), response);
        }
        
        //---------------------------------------------------------------------
        //
        // Helpers
        //
        //---------------------------------------------------------------------
        
        private function createSampleNeighbor():Node
        {
            return new Node("MOTHER");
        }

        private function addSampleResponse():Node
        {
            var response:Node = createSampleNeighbor();
            node.addResponseNeighbor(response);
            return response;
        }
        
        private function addSampleCue():Node
        {
            var cue:Node = createSampleNeighbor();
            node.addCueNeighbor(cue);
            return cue;
        }
        
        //---------------------------------------------------------------------
        //
        // Properties
        //
        //---------------------------------------------------------------------
        
        private var node:Node;
    }
}