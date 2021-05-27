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

Dim serialWork As Integer
serialWork = locationAvgRow + (tests * 6) + 12






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

For Col = 1 To numberOfColumns - 2
    For Row = 1 To tests
        Dim serialWork1 As Double
        Dim serialWork2 As Double
        serialWork1 = Abs(Cells(locationSpeedUp + Row + 1, locationAvgCol + Col + 1).Value - 1)
        serialWork2 = 1 - serialWork1
        Cells(serialWork + Row + 2, locationAvgCol + (Col * 3)).Value = serialWork1
        Cells(serialWork + Row + 2, locationAvgCol + (Col * 3) + 1).Value = serialWork2
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

Sub createCharts()
Dim SpeedupChart As ChartObject
Dim EfficiencyChart As ChartObject
Dim WorkPercentChart1 As ChartObject
Dim WorkPercentChart2 As ChartObject
Dim WorkPercentChart3 As ChartObject
Dim WorkPercentChart4 As ChartObject
Dim WorkPercentChart5 As ChartObject


Set SpeedupChart = ActiveSheet.ChartObjects.Add(Top:=0, Left:=0, Width:=5, Height:=5)
Set EfficiencyChart = ActiveSheet.ChartObjects.Add(Top:=0, Left:=0, Width:=5, Height:=5)
Set WorkPercentChart1 = ActiveSheet.ChartObjects.Add(Top:=0, Left:=0, Width:=5, Height:=5)
Set WorkPercentChart2 = ActiveSheet.ChartObjects.Add(Top:=0, Left:=0, Width:=5, Height:=5)
Set WorkPercentChart3 = ActiveSheet.ChartObjects.Add(Top:=0, Left:=0, Width:=5, Height:=5)
Set WorkPercentChart4 = ActiveSheet.ChartObjects.Add(Top:=0, Left:=0, Width:=5, Height:=5)
Set WorkPercentChart5 = ActiveSheet.ChartObjects.Add(Top:=0, Left:=0, Width:=5, Height:=5)

End Sub

Sub SpeedupChart()
createCharts

ActiveSheet.ChartObjects(1).Activate
With ActiveChart
 .HasTitle = True
 .ChartType = xlColumnClustered
 .SetSourceData Source:=Range("'test-1'!$N$33:$R$39")
 .SeriesCollection(1).Name = "2 Threads"
 .SeriesCollection(2).Name = "4 Threads"
 .SeriesCollection(3).Name = "6 Threads"
 .SeriesCollection(4).Name = "8 Threads"
 .SeriesCollection(5).Name = "12 Threads"
 .ChartTitle.Text = "Speedup"
End With

End Sub

Sub EfficiencyChart()
createCharts
ActiveSheet.ChartObjects(2).Activate
With ActiveChart
 .HasTitle = True
 .ChartType = xlColumnClustered
 .SetSourceData Source:=Range("'test-1'!$N$33:$R$39")
 .SeriesCollection(1).Name = "2 Threads"
 .SeriesCollection(2).Name = "4 Threads"
 .SeriesCollection(3).Name = "6 Threads"
 .SeriesCollection(4).Name = "8 Threads"
 .SeriesCollection(5).Name = "12 Threads"
 .ChartTitle.Text = "Efficiency"
End With


End Sub

Sub WorkPercentChart()
createCharts
ActiveSheet.ChartObjects(3).Activate
With ActiveChart
    .HasTitle = True
    .ChartType = xlColumnStacked
    .SetSourceData Source:=Range("'test-1'!$O$61:$P$67")
    .SeriesCollection(1).Name = "Serial Work"
    .SeriesCollection(2).Name = "Parallel Work"
    .ChartTitle.Text = "Work Percentage"
End With



'-----------2nd Chart--------------'

ActiveSheet.ChartObjects(4).Activate
With ActiveChart
    .HasTitle = True
    .ChartType = xlColumnStacked
    .SetSourceData Source:=Range("'test-1'!$R$61:$S$67")
    .SeriesCollection(1).Name = "Serial Work"
    .SeriesCollection(2).Name = "Parallel Work"
    .ChartTitle.Text = "Work Percentage"
End With


'-----------3rd Chart--------------'

ActiveSheet.ChartObjects(5).Activate
With ActiveChart
    .HasTitle = True
    .ChartType = xlColumnStacked
    .SetSourceData Source:=Range("'test-1'!$U$61:$V$67")
    .SeriesCollection(1).Name = "Serial Work"
    .SeriesCollection(2).Name = "Parallel Work"
    .ChartTitle.Text = "Work Percentage"
End With



'-----------4th Chart--------------'

ActiveSheet.ChartObjects(6).Activate
With ActiveChart
    .HasTitle = True
    .ChartType = xlColumnStacked
    .SetSourceData Source:=Range("'test-1'!$X$61:$Y$67")
    .SeriesCollection(1).Name = "Serial Work"
    .SeriesCollection(2).Name = "Parallel Work"
    .ChartTitle.Text = "Work Percentage"
End With



'-----------5th Chart--------------'

ActiveSheet.ChartObjects(7).Activate
With ActiveChart
    .HasTitle = True
    .ChartType = xlColumnStacked
    .SetSourceData Source:=Range("'test-1'!AA$61:$AB$67")
    .SeriesCollection(1).Name = "Serial Work"
    .SeriesCollection(2).Name = "Parallel Work"
    .ChartTitle.Text = "Work Percentage"
End With


End Sub
