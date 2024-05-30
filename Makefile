SOURCES=$(wildcard *.cpp)
OBJECTS=$(SOURCES:.cpp=.o)
DEPS=$(SOURCES:.cpp=.d)
EXECUTABLE=size

CFLAGS+=-MMD
CXXFLAGS+=-MMD -std=c++11

all: $(EXECUTABLE)

$(EXECUTABLE): $(OBJECTS)
	$(CXX) $(LDFLAGS) $^ -o $@

.PHONY: clean

clean:
	$(RM) $(OBJECTS) $(DEPS) $(EXECUTABLE)

-include $(DEPS)

