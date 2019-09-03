module TestExtension


import Test: @test, test_expr!, get_test_result, do_test, Returned

"""
    @test test_expr error_expr
    @test f(args...) error_expr key=val...

Exactly like `@test`, but evaluates `error_expr` if `@test` did not `Pass`.  

# Examples
```jldoctest
julia> @test true 37+5
Test Passed
julia> @test false 37+5
[ Info: 42
Test Failed at REPL[34]:1
  Expression: false
ERROR: There was an error during testing
```
"""
macro test(ex, msg, kws...)
    test_expr!("@test", ex, kws...)
    orig_ex = Expr(:inert, ex)
    result = get_test_result(ex, __source__)
    quote
        if !(isa($result, Returned) && isa($result.value, Bool) && $result.value)
            @info $msg
        end
        do_test($result, $orig_ex)
    end
end

end # module
