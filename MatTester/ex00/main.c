/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mlarboul <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/09/12 08:55:32 by mlarboul          #+#    #+#             */
/*   Updated: 2020/09/12 13:27:46 by mlarboul         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <unistd.h>

void	rush(int x, int y);

int	main(void)
{
	write(1, "TEST1\n", 6);
	rush(-5000000, -50000000);
	write(1, "TEST2\n", 6);
	rush(-5, -5);
	write(1, "TEST3\n", 6);
	rush(-5, 0);
	write(1, "TEST4\n", 6);
	rush(0, 0);
	write(1, "TEST5\n", 6);
	rush(0, -50);
	write(1, "TEST6\n", 6);
	rush(10, -50);
	write(1, "TEST7\n", 6);
	rush(-500, 10);
	write(1, "TEST8\n", 6);
	rush(1, 500);
	write(1, "TEST9\n", 6);
	rush(1, 0);
	write(1, "TEST10\n", 7);
	rush(1, 2);
	write(1, "TEST11\n", 7);
	rush(1, 1);
	write(1, "TEST12\n", 7);
	rush(2, 2);
	write(1, "TEST13\n", 7);
	rush(2, 1);
	write(1, "TEST14\n", 7);
	rush(0, 1);
	write(1, "TEST15\n", 7);
	rush(500, 1);
	write(1, "TEST16\n", 7);
	rush(3000, 200);
	write(1, "TEST17\n", 7);
	rush(100, 250);
	write(1, "TEST18\n", 7);
	rush(42, 121);
	write(1, "TEST19\n", 7);
	rush(4200, 20);
	write(1, "TEST20\n", 7);
	rush(1, 1);

	return (0);
}
