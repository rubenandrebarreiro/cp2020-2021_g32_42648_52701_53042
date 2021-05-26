Attribute VB_Name = "Module1"
Sub Media()


Set myCell = Application.InputBox(prompt:="Select the first cell that contains data:", Type:=8)

Dim executions As Integer
executions = InputBox("Number of executions")

Dim tests As Integer
tests = InputBox("Number of tests")

Dim threads As Integer
threads = InputBox("Number of threads, ex: 1, 2, 4, 6, 8, 12,...")

Dim numberOfColumns As Integer
numberOfColumns = (threads / 2) + 1


Dim numberOfRows As Integer
numberOfRows = executions * tests

Dim locationAvgRow As Integer
Dim locationAvgCol As Integer
Dim counterThreads As Integer
locationAvgRow = myCell.Row
locationAvgCol = myCell.Column + numberOfColumns + 2

Cells(locationAvgRow, locationAvgCol) = "sequential"
Cells(locationAvgRow, locationAvgCol + 1) = "1 thread"
Cells(locationAvgRow, locationAvgCol + 2) = "2 threads"
Cells(locationAvgRow, locationAvgCol + 3) = "4 threads"
Cells(locationAvgRow, locationAvgCol + 4) = "6 threads"
Cells(locationAvgRow, locationAvgCol + 5) = "8 threads"
Cells(locationAvgRow, locationAvgCol + 6) = "12 threads"

Dim locationStdRow As Integer
locationStdRow = locationAvgRow + tests + 2
Cells(locationStdRow, locationAvgCol) = "sequential"
Cells(locationStdRow, locationAvgCol + 1) = "1 thread"
Cells(locationStdRow, locationAvgCol + 2) = "2 threads"
Cells(locationStdRow, locationAvgCol + 3) = "4 threads"
Cells(locationStdRow, locationAvgCol + 4) = "6 threads"
Cells(locationStdRow, locationAvgCol + 5) = "8 threads"
Cells(locationStdRow, locationAvgCol + 6) = "12 threads"

Dim locationNewAvgRow As Integer
locationNewAvgRow = locationAvgRow + (tests * 2) + 4
Cells(locationNewAvgRow, locationAvgCol) = "sequential"
Cells(locationNewAvgRow, locationAvgCol + 1) = "1 thread"
Cells(locationNewAvgRow, locationAvgCol + 2) = "2 threads"
Cells(locationNewAvgRow, locationAvgCol + 3) = "4 threads"
Cells(locationNewAvgRow, locationAvgCol + 4) = "6 threads"
Cells(locationNewAvgRow, locationAvgCol + 5) = "8 threads"
Cells(locationNewAvgRow, locationAvgCol + 6) = "12 threads"

Dim locationSpeedUp As Integer
locationSpeedUp = locationAvgRow + (tests * 3) + 6
Cells(locationSpeedUp, locationAvgCol) = "sequential"
Cells(locationSpeedUp, locationAvgCol + 1) = "1 thread"
Cells(locationSpeedUp, locationAvgCol + 2) = "2 threads"
Cells(locationSpeedUp, locationAvgCol + 3) = "4 threads"
Cells(locationSpeedUp, locationAvgCol + 4) = "6 threads"
Cells(locationSpeedUp, locationAvgCol + 5) = "8 threads"
Cells(locationSpeedUp, locationAvgCol + 6) = "12 threads"

Dim locationEficency As Integer
locationEficency = locationAvgRow + (tests * 4) + 8
Cells(locationEficency + 2, locationAvgCol) = "sequential"
Cells(locationEficency + 2, locationAvgCol + 1) = "1 thread"
Cells(locationEficency + 2, locationAvgCol + 2) = "2 threads"
Cells(locationEficency + 2, locationAvgCol + 3) = "4 threads"
Cells(locationEficency + 2, locationAvgCol + 4) = "6 threads"
Cells(locationEficency + 2, locationAvgCol + 5) = "8 threads"
Cells(locationEficency + 2, locationAvgCol + 6) = "12 threads"

Dim paralleWork As Integer
paralleWork = locationAvgRow + (tests * 5) + 10
Cells(paralleWork + 2, locationAvgCol) = "sequential"
Cells(paralleWork + 2, locationAvgCol + 1) = "1 thread"
Cells(paralleWork + 2, locationAvgCol + 2) = "2 threads"
Cells(paralleWork + 2, locationAvgCol + 3) = "4 threads"
Cells(paralleWork + 2, locationAvgCol + 4) = "6 threads"
Cells(paralleWork + 2, locationAvgCol + 5) = "8 threads"
Cells(paralleWork + 2, locationAvgCol + 6) = "12 threads"


For Col = myCell.Column To myCell.Column + numberOfColumns - 1
    For numberOfTests = 0 To tests - 1
    Dim initialRow As Integer
    initialRow = myCell.Row + (numberOfTests * executions)
    Dim AverageOfThread As Double
    AverageOfThread = 0
        For Row = initialRow To initialRow + executions - 1
            AverageOfThread = AverageOfThread + Cells(Row, Col).Value
        Next
        AverageOfThread = AverageOfThread / 10
        Cells(locationAvgRow + numberOfTests + 1, myCell.Column + numberOfColumns + Col - 1).Value = AverageOfThread
        Dim SumStd As Double
        SumStd = 0
        For Row = initialRow To initialRow + executions - 1
            SumStd = SumStd + ((Cells(Row, Col).Value - AverageOfThread) ^ 2)
        Next
        SumStd = Sqr(SumStd / executions)
        Cells(locationStdRow + numberOfTests + 1, myCell.Column + numberOfColumns + Col - 1).Value = SumStd
        
        Dim AverageBasedOnStd As Double
        Dim counter As Integer
        AverageBasedOnStd = 0
        counter = 0
        For Row = initialRow To initialRow + executions - 1
            If Cells(Row, Col).Value <= AverageOfThread + SumStd And Cells(Row, Col).Value >= AverageOfThread - SumStd Then
                AverageBasedOnStd = AverageBasedOnStd + Cells(Row, Col).Value
                Cells(Row, Col).Interior.ColorIndex = 4
                counter = counter + 1
            Else
            Cells(Row, Col).Interior.ColorIndex = 3
            End If
        Next
        AverageBasedOnStd = AverageBasedOnStd / counter
        Cells(locationNewAvgRow + numberOfTests + 1, myCell.Column + numberOfColumns + Col - 1).Value = AverageBasedOnStd
    
    Next
Next


For Col = 1 To numberOfColumns - 2
    For Row = 1 To tests
        Dim speedUp As Double
        speedUp = Cells(locationNewAvgRow + Row, locationAvgCol + 1).Value / Cells(locationNewAvgRow + Row, locationAvgCol + Col + 1).Value
        Cells(locationSpeedUp + Row + 1, locationAvgCol + Col + 1).Value = speedUp
    Next
Next

Dim List As Variant
List = Array(1, 2, 4, 6, 8, 12)
For Col = 1 To numberOfColumns - 2
    For Row = 1 To tests
        Dim eficency As Double
        eficency = Cells(locationSpeedUp + Row + 1, locationAvgCol + Col + 1).Value / List(Col)
        Cells(locationEficency + Row + 2, locationAvgCol + Col + 1).Value = eficency * 100
    Next
Next

For Col = 1 To numberOfColumns - 2
    For Row = 1 To tests
        Dim overSpeedup As Double
        Dim overThreads As Double
        overSpeedup = (1 / Cells(locationSpeedUp + Row + 1, locationAvgCol + Col + 1).Value) - 1
        overThreads = (1 / List(Col)) - 1
        Cells(paralleWork + Row + 2, locationAvgCol + Col + 1).Value = (overSpeedup / overThreads)
    Next
Next


End Sub

Sub trim()
Dim Media As String
For i = 8 To NumRows
    For j = 3 To 9
      Media = Cells(i, j).Value
      Cells(i, j).Value = LTrim(Media)
    Next
Next
End Sub