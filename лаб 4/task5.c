#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <wait.h>

pid_t pid;
int fd[2];

void sigint_handler(int signo)
{
	if (signo == SIGINT)
	{
		if (pid == 0)
		{
			close(fd[0]);
			write(fd[1], "Hello World!", 12);
			exit(0);
		}
		else if (pid > 0)
		{
			char buffer[12];
			read(fd[0], buffer, sizeof(buffer));
			printf("%s\n", buffer);
			exit(0);
		}
	}
}

int main()
{
	signal(SIGINT, sigint_handler);
	pipe(fd);
	pid = fork();
        if (pid == -1)
	{
		printf("Can't fork.\n");
		return -1;
	}
	else if (pid == 0)
	{
		printf("Child. My pid: %d\n", getpid());
		while (1);
	}
	else
	{
		printf("Parent. My pid: %d\n", getpid());
		while (1);
	}
	return 0;
}
