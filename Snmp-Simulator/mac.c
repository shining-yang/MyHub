//
// File: mac.c
//
// Description: Generate a MAC by given a 16-bit number, for SNMP simulator
//
// y.s.n@live.com, 2015-06-04
//

#include <stdio.h>
#include <string.h>

// Return 0 if fail
int get_transport_id_pos(const char* para, int* offset, int* length)
{
	const char* q1 = NULL;
	const char* q2 = NULL;
	const char* p = para;
	
	while (*p) {
		if (*p == '.') {
			q1 = q2;
			q2 = p;
		}
		p++;
	}

	if (q1 == NULL || q2 == NULL) {
		return 0;
	}

	*offset = (int)(q1 - para + 1);
	*length = (int)(q2 - q1 - 1);
	return 1;
}

int main(int argc, char* argv[])
{
	unsigned short trans_id = 0;
	if (argc > 1) {
		char data[16] = { 0 };
		int offset, length;
		if (get_transport_id_pos(argv[1], &offset, &length)) {
			memcpy(data, argv[1] + offset, length);
			trans_id = (unsigned short)atoi(data);
		}
	}

	printf("001a1a1a%04x", trans_id);
}

