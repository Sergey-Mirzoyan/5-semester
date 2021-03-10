#include <stdio.h>
#include <wait.h>
#include <unistd.h>

int main()
{
	int fd[2];
	pipe(fd);
	pid_t pid = fork();
        if (pid == -1)
	{
		printf("Can't fork.\n");
		return -1;
	}
	else if (pid == 0)
	{
		printf("Child. My pid: %d\n", getpid());
		close(fd[0]);
		sleep(3);
		write(fd[1], "Hello World!", 12);
	}
	else
	{
		printf("Parent. My pid: %d\n", getpid());
		wait(NULL);
		close(fd[1]);
		char buffer[12];
		read(fd[0], buffer, sizeof(buffer));
		printf("%s\n", buffer);
	}
	return 0;
}
