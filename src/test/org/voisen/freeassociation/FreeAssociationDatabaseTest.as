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
    import org.hamcrest.number.greaterThan;
    import org.voisen.freeassociation.FreeAssociationDatabase;
    import org.voisen.freeassociation.data.CSVData;
    
    import test.org.voisen.freeassociation.data.CSVDataTest;

	public class FreeAssociationDatabaseTest
	{		
        private var database:FreeAssociationDatabase;
        
		[Before]
		public function setUp():void
		{
            database = new FreeAssociationDatabase();
		}
		
		[After]
		public function tearDown():void
		{
            database = null;
		}
		
		[Test]
        public function should_be_able_to_instantiate():void
        {
            assertNotNull(database);     
        }
        
        [Test]
        [Ignore]
        public function node_count_should_be_positive_after_initialize():void
        {
           database.initialize(); 
           
           assertThat(database.nodeCount, greaterThan(0));
        }
	}
}