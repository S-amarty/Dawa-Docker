import java.util.List;

@RestController
@RequestMapping("/api")

public class PrimeNumbersController {
    @Autowired
    private PrimeNumberService primeNumberService;

    @GetMapping(/"prime"")
    public ResponseEntity<List></integer>>getPrimes(@RequestParam String numbers)
    {
        List<integer> primes = processor.process(numbers);
        return
                ResponseEntity.ok(primes);
    }
}

@Component
public class PrimeNumberProcessor {
    public List<integer> process(String input) {
        return
                Array.stream(input.split(",")).map(String::trim)
                        .filter(this::isPrime)
                        .sorted()

    }
}