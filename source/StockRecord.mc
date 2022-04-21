using Toybox.Application;

(:glance)
class StockRecord
{
	public var Code;
	public var Close;
	public var ChangePercent;
	public var Change;
	public var High;
	public var Low;
	public var Volume;
	
	public function initialize(code, close, changePercent, change, high, low, volume)
	{
		Code = code;
		Close = close;
		ChangePercent = changePercent;
		Change = change;
		High = high;
		Low = low;
		Volume = volume;
	}
	
	// Using the unique stock code for the hash code
	function hashCode() 
	{
		return Code;
	}
}