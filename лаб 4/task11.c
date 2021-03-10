#include <stdio.h>
#include <unistd.h>

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
		printf("Child. My pid: %d\n", getpid());
		printf("Child. Parent pid: %d\n", getppid());
		printf("Child. Group pid: %d\n", getpgrp());
	}
	else
	{
		printf("Parent. My pid: %d\n", getpid());
		printf("Parent. Child pid: %d\n", pid);
		printf("Parent. Group pid: %d\n", getpgrp());
	}
	return 0;
}
