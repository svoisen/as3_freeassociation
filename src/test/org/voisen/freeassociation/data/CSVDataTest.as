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
    import org.flexunit.asserts.assertNotNull;
    import org.hamcrest.object.equalTo;
    import org.voisen.freeassociation.data.CSVData;

    public class CSVDataTest
    {		
        private var csvData:CSVData;
        
        public static const CSV_DATA_ROW_COUNT:int = 72176;
        
        [Before]
        public function setUp():void
        {
            csvData = new CSVData();
        }
        
        [After]
        public function tearDown():void
        {
            csvData = null;
        }
        
        [Test]
        public function should_be_able_to_instantiate():void
        {
           assertNotNull(csvData); 
        }
        
        [Test]
        public function should_be_able_to_get_rows():void
        {
            assertNotNull(csvData.rows);
            assertThat(csvData.rows.length, equalTo(CSV_DATA_ROW_COUNT));
        }
    }
}