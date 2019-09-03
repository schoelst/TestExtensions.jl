using TestExtension
using Test

@testset "@test" begin
    @test true 37+5
    @test false 37+5 end

end