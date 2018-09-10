using System;
using Xunit;

namespace App.Tests
{
    public class UnitTest1
    {
        [Fact]
        public void Test1()
        {
            Console.WriteLine("Hello from xUnit (regular test)");
        }

        [Fact, Trait("category", "integration")]
        public void Test2()
        {
            Console.WriteLine("Hello from xUnit (integration test)");
        }
    }
}
