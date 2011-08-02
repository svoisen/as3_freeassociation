package test.org.voisen.freeassociation
{
    import org.flexunit.asserts.assertNotNull;
    import org.voisen.freeassociation.FreeAssociationDatabase;

	public class FreeAssociationDatabaseTest
	{		
        private var database:FreeAssociationDatabase;
        
		[Before]
		public function setUp():void
		{
            database = new FreeAssociationDatabase():
		}
		
		[After]
		public function tearDown():void
		{
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
            assertNotNull(database);     
        }
        
        [Test]
        public function should_initialize_from_csv_data():void
        {
           database.initialize(); 
        }
	}
}