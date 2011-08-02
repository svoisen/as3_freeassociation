package test.org.voisen.freeassociation.data
{
    import org.flexunit.asserts.assertNotNull;
    import org.voisen.freeassociation.data.RawCSVData;

    public class RawCSVDataTest
    {		
        private var csvData:RawCSVData;
        
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
    }
}