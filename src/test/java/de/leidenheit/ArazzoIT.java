package de.leidenheit;

import de.leidenheit.core.model.ArazzoSpecification;
import de.leidenheit.infrastructure.io.InputsReader;
import de.leidenheit.integration.ItarazzoDynamicTest;
import de.leidenheit.integration.extension.ItarazzoExtension;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.DynamicTest;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.TestFactory;
import org.junit.jupiter.api.extension.ExtendWith;

import java.util.stream.Stream;

@ExtendWith(ItarazzoExtension.class)
class ArazzoIT {

    @TestFactory
    @DisplayName("Workflow")
    Stream<DynamicTest> testMyArazzo(final ArazzoSpecification arazzo, final String inputsFilePath) {
        var inputs = InputsReader.readInputs(inputsFilePath);
        ItarazzoDynamicTest dynamicTest = new ItarazzoDynamicTest();
        return Assertions.assertDoesNotThrow(() -> dynamicTest.generateWorkflowTests(arazzo, inputs));
    }
}
