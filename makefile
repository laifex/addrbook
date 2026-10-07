SHELL := pwsh.exe
.SHELLFLAGS := -NoProfile -Command

CC = gcc
CFLAGS = -Wall -g -MMD -MP -Iinclude
TARGET  = build/addrbook.exe

SRCS    = $(wildcard src/*.c)
OBJS    = $(patsubst src/%.c,build/%.o,$(SRCS))

.PHONY: all clean run

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $^ -o $@

build/%.o: src/%.c | build
	$(CC) $(CFLAGS) -c $< -o $@

build:
	New-Item -ItemType Directory -Force -Path build

-include $(OBJS:.o=.d)

run: $(TARGET)
	./$(TARGET)

clean:
	Remove-Item -Recurse -Force build -ErrorAction SilentlyContinue