package test.org.voisen.freeassociation.data
{
    import org.flexunit.assertThat;
    import org.flexunit.asserts.assertNotNull;
    import org.hamcrest.object.equalTo;
    import org.voisen.freeassociation.data.RawCSVData;

    public class RawCSVDataTest
    {		
        private var csvData:RawCSVData;
        
        private static const CSV_DATA_ROW_COUNT:int = 72176;
        
        [Before]
        public function setUp():void
        {
            csvData = new RawCSVData();
        }
        
        [After]
        public function tearDown():void
        {
            csvData = null;
        }
        
        [BeforeClass]
        public static function setUpBeforeClass():void
        {
        }
        
        [AfterClass]
        public static function tearDownAfterClass():void
        {
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