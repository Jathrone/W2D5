require "set"
def base_ten_xor(array1, array2)
    #limit both arrays of numbers to first and tenth place
    first_set = Set.new
    tenth_set = Set.new
    array1.each do |num1|
        first, tenth = num1 % 10, num1 / 10
        if first_set.include?(first)
            first_set.delete(first)
        else
            first_set << first
        end
        if tenth_set.include?(tenth)
            tenth_set.delete(tenth)
        else
            tenth_set << tenth
        end
    end
    array2.each do |num2|
        first, tenth = num2 % 10, num2 / 10
        if first_set.include?(first)
            first_set.delete(first)
        else
            first_set << first
        end
        if tenth_set.include?(tenth)
            tenth_set.delete(tenth)
        else
            tenth_set << tenth
        end
    end
    return 10 * tenth_set.keys[0] + first_set.keys[0]
end

arr1 = [11, 34, 89, 74, 55]
arr1 = [11, 89, 74, 55]

