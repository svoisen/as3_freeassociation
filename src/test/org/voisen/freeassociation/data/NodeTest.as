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
        public function should_be_able_to_add_target():void
        {
            addSampleTarget();
            
            assertEquals(node.targetCount, 1);
        }
        
        [Test]
        public function should_be_able_to_check_if_target_exists():void
        {
            var target:Node = addSampleTarget();
            
            assertTrue(node.hasTarget(target));
        }
        
        [Test]
        public function should_be_able_to_add_cue():void
        {
            addSampleCue();
            
            assertEquals(node.cueCount, 1);
        }
        
        [Test]
        public function should_not_add_duplicate_cues():void
        {
           var cue:Node = addSampleCue(); 
           node.addCue(cue);
           
           assertEquals(node.cueCount, 1);
        }
        
        [Test]
        public function should_be_able_to_check_if_cue_exists():void
        {
            var cue:Node = addSampleCue();
            
            assertTrue(node.hasCue(cue));
        }
        
        [Test]
        public function should_add_self_as_cue_to_target():void
        {
            var target:Node = addSampleTarget();
            
            assertThat(target.hasCue(node));
        }
                
        [Test]
        public function should_be_able_to_remove_target_by_word():void
        {
            addSampleTarget();
            
            var result:Boolean = node.removeTargetWithWord("MOTHER");
            
            assertTrue(result);
            assertEquals(node.targetCount, 0);
        }
        
        [Test]
        public function should_be_able_to_determine_if_target_already_exists_by_word():void
        {
            var target:Node = addSampleTarget();
            
            assertTrue(node.hasTargetWithWord(target.word))
        }
        
        [Test]
        public function should_be_able_to_get_target_by_word():void
        {
            var target:Node = addSampleTarget();
            
            assertEquals(node.getTargetWithWord(target.word), target);
        }
        
        [Test]
        public function should_be_case_insensitive_when_searching_targets_by_word():void
        {
           var target:Node = addSampleTarget();
           
           assertEquals(node.getTargetWithWord("mOTheR"), target);
        }
        
        //---------------------------------------------------------------------
        //
        // Helpers
        //
        //---------------------------------------------------------------------
        
        private function createSampleNode():Node
        {
            return new Node("MOTHER");
        }

        private function addSampleTarget():Node
        {
            var target:Node = createSampleNode();
            node.addTarget(target);
            return target;
        }
        
        private function addSampleCue():Node
        {
            var cue:Node = createSampleNode();
            node.addCue(cue);
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