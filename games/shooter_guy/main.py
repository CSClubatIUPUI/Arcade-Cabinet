import pygame
pygame.init()


def main():
    win = pygame.display.set_mode((500, 500))
    pygame.display.set_caption("Shooter Guy")

    x = 50
    y = 50
    width = 40
    height = 60
    vel = 10

    run = True

    while run:

        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                run = False

        keys = pygame.key.get_pressed()

        if keys[pygame.K_w]:
            if y - vel < 0:
                y = 0
            else:
                y -= vel
        if keys[pygame.K_a]:
            if x - vel < 0:
                x = 0
            else:
                x -= vel
        if keys[pygame.K_s]:
            if (y + height) + vel > 500:
                y = 500 - height
            else:
                y += vel
        if keys[pygame.K_d]:
            if (x + width) + vel > 500:
                x = 500 - width
            else:
                x += vel

        win.fill((0, 0, 0))
        pygame.draw.rect(win, (255, 0, 0), (x, y, width, height))
        pygame.display.update()

    pygame.quit()


if __name__ == "__main__":
    main()
