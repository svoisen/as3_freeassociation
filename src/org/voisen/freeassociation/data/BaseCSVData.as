package org.voisen.freeassociation.data
{
    import flash.utils.ByteArray;

    public class BaseCSVData implements ICSVData
    {
        public function get rows():Vector.<String>
        {
            return _rows;
        }
        
        protected function populateRows(bytes:ByteArray):void
        {
            _rows = Vector.<String>(bytes.readUTFBytes(bytes.length).split('\n'));
        }
        
        protected var _rows:Vector.<String>;
    }
}