package test.org.voisen.freeassociation
{
    import test.org.voisen.freeassociation.FreeAssociationDatabaseTest;
    import test.org.voisen.freeassociation.data.RawCSVDataTest;
    
    [Suite]
    [RunWith("org.flexunit.runners.Suite")]
    public class FreeAssociationTestSuite
    {
        public var freeAssociationDatabaseTest:FreeAssociationDatabaseTest;
        public var rawCSVDataTest:RawCSVDataTest;
    }
}