#include <stdio.h>
#include <wait.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

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

		int status;
		pid_t child_pid = wait(&status);
		printf("Child has finished. PID: %d\n", child_pid);

		if (WIFEXITED(status))
		{
			printf("Child terminated normally\n");
		}
		else
		{
			printf("Child exited, code: %d\n", WEXITSTATUS(status));
		}
	}
	return 0;
}
