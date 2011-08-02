package org.voisen.freeassociation.data
{
    import flash.utils.ByteArray;

    public class RawCSVData
    {
        [Embed(source="assets/data.csv", mimeType="application/octet-stream")]
        private var data:Class;
        
        private var _rows:Vector.<String>;
        
        public function RawCSVData()
        {
        }

        public function get rows():Vector.<String>
        {
            return _rows;
        }
    }
}