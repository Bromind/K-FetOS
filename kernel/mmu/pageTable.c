

void setTTBR0(void* translation_table_base_address, char outer_cacheable_attributes, char EEC_support, char shared, char inner_cacheable, int N)
{
	int value = (int) translation_table_base_address << (14-N) | 
		(int) (outer_cacheable_attributes & (char) 3) << 3 | 
		(int) (EEC_support & (char) 1) << 2 |
		(int) (shared & (char) 1) << 1 |
		(int) (inner_cacheable & (char) 1);

	
}
