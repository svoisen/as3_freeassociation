package org.voisen.freeassociation.data
{
    import flash.utils.ByteArray;

    public class RawCSVData
    {
        [Embed(source="assets/data.csv", mimeType="application/octet-stream")]
        private const RawData:Class;
        
        private var _rows:Vector.<String>;
        
        public function RawCSVData()
        {
        }

        public function get rows():Vector.<String>
        {
            if (!_rows)
                populateRows(); 
            
            return _rows;
        }

        private function populateRows():void
        {
            var bytes:ByteArray = new RawData() as ByteArray;
            _rows = Vector.<String>(bytes.readUTFBytes(bytes.length).split('\n'));
        }
    }
}