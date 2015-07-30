#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>             /* internet definitions */
#include <netdb.h>                  /* computer information */
#include <strings.h>
#include <string.h>

#include "seedserve.h"

int seedserve_get_seed(void)
{
    char * service_port_string;
    int service_port;
    int  sd;
    struct hostent *host_info;
    char digit;
    int ret;
    struct sockaddr_in socket_address;
    const char const * fetch_cmd = "FETCH\n";

    service_port_string = getenv("SEEDSERVE_PORT");
    if (service_port_string == NULL)
    {
        service_port = 3000;
    }
    else
    {
        service_port = atoi(service_port_string);
    }

    /* get socket descriptor for INTERNET, STREAM protocol               */
    sd = socket(AF_INET, SOCK_STREAM, 0);
    if (sd == -1)
    {
		return -1;
    }

    host_info = gethostbyname("localhost");
    if (host_info == NULL)
    {
        close(sd);
        return -1;
    }

    bzero(&socket_address,sizeof(socket_address));   /* just zero struct */
    socket_address.sin_family = AF_INET;    /* indicate INTERNET address */
    socket_address.sin_port = htons(service_port);    /* port in computer */
    bcopy(host_info->h_addr,
		&socket_address.sin_addr,
		host_info->h_length);            /* computer address (4 bytes) */


    /* connect to the server - blocks until connection established       */
    if (connect(sd,(struct sockaddr *)&socket_address,sizeof(socket_address)) == -1)
    {
        close(sd);
        return -1;
    }

    write(sd, fetch_cmd, strlen(fetch_cmd));

    ret = 0;
    while (read(sd, &digit, sizeof(digit)) == 1)
    {
        if ((digit >= '0') && (digit <= '9'))
        {
            ret = ret * 10 + (int)(digit-'0');
        }
        else
        {
            break;
        }
    }

    close(sd);

    return ret;
}

