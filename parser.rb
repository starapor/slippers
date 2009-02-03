require 'rubygems'
require 'rparsec'
include RParsec
class Calculator
  include Parsers
  include Functors
  Sarah = proc{|x,y|2*x+2*y}
  def parse(statement)
    the_parser.parse(statement)
  end
  private
    def the_parser
      ops = OperatorTable.new.
        infixl(char(?+) >> Plus, 20).
        infixl(char(?-) >> Minus, 20).
        infixl(char(?*) >> Mul, 40).
        infixl(char(?/) >> Div, 40).
        prefix(char(?-) >> Neg, 60)
      expr = nil
      term = integer.map(&To_i) | char('(') >> lazy{expr} << char(')')
      delim = whitespace.many_
      expr = delim >> Expressions.build(term, ops, delim)
    end
end


puts Calculator.new.parse '1+2*(3-1)'
