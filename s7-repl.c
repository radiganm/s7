#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <libtecla.h>
#include "s7.h"

int main(int argc, char **argv)
{
  s7_scheme *s7;
  char *buffer;
  char response[1024];
  GetLine *gl;            /* The tecla line editor */

  gl = new_GetLine(500, 5000);
  s7 = s7_init();  

  if (argc == 2)
  {
    fprintf(stderr, "load %s\n", argv[1]);
    s7_load(s7, argv[1]);
  }
  else 
  {
    while (1) 
    {
       buffer = gl_get_line(gl, "> ", NULL, 0);
       if ((buffer[0] != '\n') || (strlen(buffer) > 1))
       {                            
         sprintf(response, "(write %s)", buffer);
         s7_eval_c_string(s7, response);
         fprintf(stdout, "\n");
       }
    }
    gl = del_GetLine(gl);
  }

  return EXIT_SUCCESS;
}
