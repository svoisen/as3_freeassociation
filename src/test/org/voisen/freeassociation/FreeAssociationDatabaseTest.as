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

package test.org.voisen.freeassociation
{
    import org.flexunit.assertThat;
    import org.flexunit.asserts.assertEquals;
    import org.flexunit.asserts.assertNotNull;
    import org.flexunit.asserts.assertNull;
    import org.flexunit.asserts.assertTrue;
    import org.hamcrest.number.greaterThan;
    import org.voisen.freeassociation.FreeAssociationDatabase;
    import org.voisen.freeassociation.data.FullUSFData;
    import org.voisen.freeassociation.data.MinimalUSFData;
    import org.voisen.freeassociation.search.SearchTypes;

    public class FreeAssociationDatabaseTest
    {		
        //---------------------------------------------------------------------
        //
        // Prep
        //
        //---------------------------------------------------------------------
        
        [BeforeClass]
        public static function setUpClass():void
        {
            database = new FreeAssociationDatabase();
            database.initialize(new MinimalUSFData());
        }
        
        [AfterClass]
        public static function tearDownClass():void
        {
           database = null; 
        }
        
        [Before]
        public function setUp():void
        {
            
        }
		
        [After]
        public function tearDown():void
        {
            
        }
		
        //---------------------------------------------------------------------
        //
        // Tests
        //
        //---------------------------------------------------------------------
        
        [Test]
        public function should_be_able_to_instantiate():void
        {
            assertNotNull(database);     
        }
        
        [Test]
        public function word_count_should_be_positive_after_initialize():void
        {
           assertThat(database.wordCount, greaterThan(0));
        }
        
        [Test]
        public function should_be_able_to_check_if_word_exists():void
        {
           assertTrue(database.hasWord("AARDVARK")); 
        }
        
        [Test]
        public function should_ignore_case_on_word_check():void
        {
           assertTrue(database.hasWord("aaRdVark")); 
        }
        
        [Test]
        public function should_have_valid_data():void
        {
            assertThat(database.getTargetsForCue("aardvark").indexOf("ANIMAL"), greaterThan(-1));     
        }
        
        [Test]
        public function should_get_cues_for_target():void
        {
            var cues:Vector.<String> = database.getCuesForTarget("animal");
            
            assertNotNull(cues);
            assertThat(cues.indexOf("AARDVARK"), greaterThan(-1));
        }
        
        [Test]
        public function should_not_search_for_words_that_dont_exist():void
        {
            assertNull(database.findCueTargetPath("xxxxxxx", "mother"));
            assertNull(database.findCueTargetPath("mother", "xxxxxxx"));
        }
        
        [Test]
        public function should_return_path_of_length_one_for_trivial_dfs():void
        {
            var path:Vector.<String> = database.findCueTargetPath("word", "word", SearchTypes.DFS); 
            assertEquals(path.length, 1); 
        }
        
        [Test]
        public function should_return_identity_node_for_trivial_dfs():void
        {
            assertEquals(database.findCueTargetPath("word", "word", SearchTypes.DFS)[0], "WORD"); 
        }
        
        [Test]
        public function should_return_correct_path_for_short_dfs():void
        {
            assertEquals(database.findCueTargetPath("aardvark", "animal", SearchTypes.DFS).length, 2);
        }
        
        [Test]
        public function should_return_correct_path_for_medium_dfs():void
        {
            var path:Vector.<String> = database.findCueTargetPath("aardvark", "dog", SearchTypes.DFS);
            assertEquals(path.length, 3);
            assertEquals(path[0], "AARDVARK");
        }
        
        [Test]
        public function should_return_correct_path_for_short_bfs():void
        {
            assertEquals(database.findCueTargetPath("aardvark", "zoo").length, 2);
        }
        
        [Test]
        public function should_return_correct_path_for_medium_bfs():void
        {
            var path:Vector.<String> = database.findCueTargetPath("aardvark", "mother");
            
            assertEquals(path.length, 4);
            assertEquals(path[0], "AARDVARK");
            assertEquals(path[1], "ZOO");
            assertEquals(path[2], "KEEPER");
            assertEquals(path[3], "MOTHER");
        }
        
        [Test]
        public function should_return_correct_target_cue_path_for_small_bfs():void
        {
            var path:Vector.<String> = database.findTargetCuePath("zoo", "aardvark");
            
            assertEquals(path.length, 2);
        }
        
        [Test]
        public function should_return_correct_bidirectional_path_for_small_bfs():void
        {
            var path:Vector.<String> = database.findPath("zoo", "aardvark");
            
            assertEquals(path.length, 2);
            assertEquals(path[0], "ZOO");
            assertEquals(path[1], "AARDVARK");
        }
        
        [Test]
        public function should_return_correct_bidirectional_path_for_medium_bfs():void
        {
            var path:Vector.<String> = database.findPath("word", "mother");
            assertEquals(path.length, 3);
            assertEquals(path[1], "ADVICE");
        }
        
        //---------------------------------------------------------------------
        //
        // Properties
        //
        //---------------------------------------------------------------------
        
        private static var database:FreeAssociationDatabase;
    }
}