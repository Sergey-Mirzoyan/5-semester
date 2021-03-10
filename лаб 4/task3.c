#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <wait.h>


int main()
{
	pid_t pid = fork();
        if (pid == -1)
	{
		printf("Can't fork.\n");
		return -1;
	}
	else if (pid == 0)
	{
		char *argv[2];
		argv[0] = "ls";
		argv[1] = NULL;
		execvp(argv[0], argv);
		perror("execve failed.\n");
		return -1;
	}
	else
	{
		printf("Waiting for child to finish...\n");
		wait(NULL);
	}
	return 0;
}
