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
    import org.flexunit.asserts.assertNotNull;
    import org.voisen.freeassociation.data.Edge;

    public class EdgeTest
    {
        //---------------------------------------------------------------------
        //
        // Prep
        //
        //---------------------------------------------------------------------
        
        [Before]
        public function setUp():void
        {
            edge = new Edge("word");     
        }
        
        [After]
        public function tearDown():void
        {
           edge = null; 
        }
        
        //---------------------------------------------------------------------
        //
        // Tests
        //
        //---------------------------------------------------------------------
        
        [Test]
        public function should_set_word_from_constructor():void
        {
           assertNotNull(edge.word); 
        }
        
        [Test]
        public function should_set_word_from_setter():void
        {
            edge.word = "foo";
            assertEquals(edge.word.toLowerCase(), "foo");
        }
        
        [Test]
        public function should_convert_word_to_uppercase():void
        {
           edge.word = "word";
           assertEquals(edge.word, "WORD"); 
        }
        
        //---------------------------------------------------------------------
        //
        // Properties
        //
        //---------------------------------------------------------------------
        
        private var edge:Edge;
    }
}