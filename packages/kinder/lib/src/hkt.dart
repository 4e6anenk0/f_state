sealed class Kinder<Instance, T> {}

typedef Kinder2<Instance, T1, T2> = Kinder<Kinder<Instance, T1>, T2>;

typedef Kinder3<Instance, T1, T2, T3> = Kinder<Kinder2<Instance, T1, T2>, T3>;

typedef Kinder4<Instance, T1, T2, T3, T4>
    = Kinder<Kinder3<Instance, T1, T2, T3>, T4>;

typedef Kinder5<Instance, T1, T2, T3, T4, T5>
    = Kinder<Kinder4<Instance, T1, T2, T3, T4>, T5>;

typedef Kinder6<Instance, T1, T2, T3, T4, T5, T6>
    = Kinder<Kinder5<Instance, T1, T2, T3, T4, T5>, T6>;

typedef Kinder7<Instance, T1, T2, T3, T4, T5, T6, T7>
    = Kinder<Kinder6<Instance, T1, T2, T3, T4, T5, T6>, T7>;

typedef Kinder8<Instance, T1, T2, T3, T4, T5, T6, T7, T8>
    = Kinder<Kinder7<Instance, T1, T2, T3, T4, T5, T6, T7>, T8>;

typedef Kinder9<Instance, T1, T2, T3, T4, T5, T6, T7, T8, T9>
    = Kinder<Kinder8<Instance, T1, T2, T3, T4, T5, T6, T7, T8>, T9>;
