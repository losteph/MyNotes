class AreaCapacity:
    def __init__(self, area, maxCapacity):
        self.area = area
        self.maxCapacity = maxCapacity
    
    def check(self, assignment):
        count = 0
        for var, assignedArea in assignment.items():
            if assignedArea == self.area:
                count += 1
        return count <= self.maxCapacity